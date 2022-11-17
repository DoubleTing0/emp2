package vo;

public class EmployeeTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Employee e = new Employee();
		/*
		e.empNo = 1;
		e.birthDate = "2000-01-01";
		e.setBirthDate("2000-01-01");
		e.gender = "여";
		e.hireDate = "2022-11-11";
		*/
		
		System.out.println(e.getBirthDate() + " <-- e.birthDate");
		
		Employee e2 = new Employee();
		e2.setBirthDate("2000-01-02");
		System.out.println(e2.getBirthDate());
		
		
		
	}

}
