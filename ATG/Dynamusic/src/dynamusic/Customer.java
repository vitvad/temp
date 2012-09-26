package dynamusic;

import atg.nucleus.GenericService;

public class Customer extends GenericService {

	private String name;

	private int age;

	private String position;

	/* Constructors */
	public Customer() {
		if (isLoggingDebug()) {
			logDebug("Customer constructor called");
		}
	}

	/* Methods */
	public String getName() {
		return name;
	}

	public void setName(String names) {
		this.name = names;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

}
