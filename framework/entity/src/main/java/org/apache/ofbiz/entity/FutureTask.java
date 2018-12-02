package org.apache.ofbiz.entity;

import java.io.Serializable;
import java.util.concurrent.Callable;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.RunnableFuture;
import java.util.concurrent.locks.LockSupport;

public class FutureTask<V> extends java.util.concurrent.FutureTask<V> implements Serializable {

	public FutureTask(Callable<V> callable) {
		super(callable);
	}
}