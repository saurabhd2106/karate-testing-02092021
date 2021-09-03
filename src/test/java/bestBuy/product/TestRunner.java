package bestBuy.product;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestRunner {

	@Test
	public Karate runTest() {
		return	Karate.run("productApiTest", "productApiTest2").tags("~Ignore").relativeTo(getClass());
	}
	
}
