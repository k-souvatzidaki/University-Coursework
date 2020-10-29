//Department of Informatics, AUEB

import java.io.IOException;

public class TestCacheSpeed {

	public static void main(String[] args) throws IOException {
		
		int cachesize = 100;
		//initialize with your cache implementation		
		Cache<String, String> cache = new CacheImpl<String, String>(cachesize);		
		
		//give path to the dat file
		String dataFile = "datasets/dataset-1000/data-1000.dat";
		
		//give path to the workload file
		String requestsFile = "datasets/dataset-1000/requests-10000.dat";

		DataSource dataSource = new DataSource(dataFile);
		WorkloadReader requestReader = new WorkloadReader(requestsFile);
		
		String key = null;		
		long numberOfRequests = 0;
		
		/*start performance test*/
		
		//track current time
		long startTime = System.currentTimeMillis();
		
		while ((key = requestReader.nextRequest()) != null) {
			System.out.println("requests " + numberOfRequests++);
			String data = (String)cache.lookUp(key);
			if (data == null) {//data not in cache
				data = dataSource.readItem(key);
				if (data == null) {
					throw new IllegalArgumentException("DID NOT FIND DATA WITH KEY " + key +". Have you set up files properly?");
				}else{
					cache.store(key, data);
				}
			}			
		}

		/*speed test finished*/
		long duration = System.currentTimeMillis() - startTime;
		
		System.out.printf("Read %d items in %d ms\n", numberOfRequests,	duration);
		System.out.printf("Stats: lookups %d, hits %d, hit-ratio %f\n", cache.getNumberOfLookUps(), cache.getHits(), cache.getHitRatio());
 
		
		requestReader.close();
	}
}