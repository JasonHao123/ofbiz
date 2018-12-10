/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package org.apache.ofbiz.entity.connection;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import javax.transaction.TransactionManager;

import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.entity.GenericEntityConfException;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.config.model.EntityConfig;
import org.apache.ofbiz.entity.config.model.InlineJdbc;
import org.apache.ofbiz.entity.config.model.JdbcElement;
import org.apache.ofbiz.entity.datasource.GenericHelperInfo;
import org.apache.ofbiz.entity.transaction.TransactionFactoryLoader;
import org.apache.ofbiz.entity.transaction.TransactionUtil;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

/**
 * Apache Commons DBCP connection factory.
 * 
 * @see <a href="http://commons.apache.org/proper/commons-dbcp/">Apache Commons DBCP</a>
 */
public class HikariConnectionFactory implements ConnectionFactory {

    public static final String module = HikariConnectionFactory.class.getName();
    // ManagedDataSource is useful to debug the usage of connections in the pool (must be verbose)
    // In case you don't want to be disturbed in the log (focusing on something else), it's still easy to comment out the line from DebugManagedDataSource
    protected static final ConcurrentHashMap<String, HikariDataSource> dsCache = new ConcurrentHashMap<String, HikariDataSource>();

    public Connection getConnection(GenericHelperInfo helperInfo, JdbcElement abstractJdbc) throws SQLException, GenericEntityException {
        String cacheKey = helperInfo.getHelperFullName();
        HikariDataSource mds = dsCache.get(cacheKey);
        if (mds != null) {
            return TransactionUtil.getCursorConnection(helperInfo, mds.getConnection());
        }
        if (!(abstractJdbc instanceof InlineJdbc)) {
            throw new GenericEntityConfException("DBCP requires an <inline-jdbc> child element in the <datasource> element");
        }
        InlineJdbc jdbcElement = (InlineJdbc) abstractJdbc;
        // connection properties
        TransactionManager txMgr = TransactionFactoryLoader.getInstance().getTransactionManager();
        String driverName = jdbcElement.getJdbcDriver();

        String jdbcUri = helperInfo.getOverrideJdbcUri(jdbcElement.getJdbcUri());
        String jdbcUsername = helperInfo.getOverrideUsername(jdbcElement.getJdbcUsername());
        String jdbcPassword = helperInfo.getOverridePassword(EntityConfig.getJdbcPassword(jdbcElement));

        // pool settings
        int maxSize = jdbcElement.getPoolMaxsize();
        int minSize = jdbcElement.getPoolMinsize();
        int maxIdle = jdbcElement.getIdleMaxsize();
        // maxIdle must be greater than pool-minsize
        maxIdle = maxIdle > minSize ? maxIdle : minSize;
        // load the driver
        Driver jdbcDriver;
        synchronized (HikariConnectionFactory.class) {
            // Sync needed for MS SQL JDBC driver. See OFBIZ-5216.
            try {
                jdbcDriver = (Driver) Class.forName(driverName, true, Thread.currentThread().getContextClassLoader()).newInstance();
            } catch (Exception e) {
                Debug.logError(e, module);
                throw new GenericEntityException(e.getMessage(), e);
            }
        }

        // connection factory properties
        Properties cfProps = new Properties();
        cfProps.put("user", jdbcUsername);
        cfProps.put("password", jdbcPassword);


        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(jdbcUri);
        config.setUsername(jdbcUsername);
        config.setPassword(jdbcPassword);
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        mds = new HikariDataSource(config);

        // cache the pool
        dsCache.putIfAbsent(cacheKey, mds);
        mds = dsCache.get(cacheKey);

        return TransactionUtil.getCursorConnection(helperInfo, mds.getConnection());
    }

    public void closeAll() {
        // no methods on the pool to shutdown; so just clearing for GC
        dsCache.clear();
    }

    public static Map<String, Object> getDataSourceInfo(String helperName) {
        Map<String, Object> dataSourceInfo = new HashMap<String, Object>();
        HikariDataSource mds = dsCache.get(helperName);

        return dataSourceInfo;
    }

}
