package api.utility.data;

public class GenerateData {
	
	public static String getEmail() {
		
		String prefix = "instructor_email";
		String provider = "@tekschool.us";
		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider;
		return email;	
		
	
	}
	
	// generate random phone # 10 digit
		// @return String random phone number 
	
	public static String getPhoneNumber() {
		String phoneNumber = "2";
		for(int i =0; i < 9; i++) {
			phoneNumber += (int) (Math.random() * 10);
			
		}
		return phoneNumber;
	}
//	public static void main(String[] args) {
//		String number = getPhoneNumber();
//		System.out.println(number);
//		
//
//	}
	
	public static String getAddress() {
		String addressType = "Residential";
		String addressLine1 = " Connecticut Ave";
		String city = "";
		String state = "";
		String postalCode = "";
//			for(int i = 0; i < 5; i++) {
//				postalCode += (int) (Math.random() * 5);
//		
//			}
			String countrycode = "US";
			int streetNumber = (int) (Math.random() * 10000);
			String fullAddress = streetNumber + addressLine1 + city + state + postalCode;
			
			return fullAddress;
			
		
	}
	
	public static String getCar() {
		
		String make = "";
		String model = "";
		String year = "";
		String plateNumber = "US";
			for(int i = 0; i < 5; i++) {
				plateNumber += (int) (Math.random() * 5);
			}
			
			return plateNumber;
		
		
		
		
	}
	
	public static void main(String[] args) {
		
		String address = getAddress();
		System.out.println(address);
		
		String car = getCar();
		System.out.println(car);
		
	}


		
	

}
