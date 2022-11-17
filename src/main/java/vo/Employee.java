package vo;

// 캡슐화 단계 : public(100% 오픈) > protected(같은 패키지와 상속관계 오픈) > default(아무것도 안적음)(같은 패키지) > private(this 오픈) 
// protected, default 단계의 캡슐화는 입문자는 사용하지 않는다.
public class Employee {
	// 정보 은닉
	private int empNo;
	private String birthDate;
	private String firstName;
	private String lastName;
	private String gender;
	private String hireDate;
	
	
	
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	
	
	/*
	// 캡슐화(읽기)
	public String getBirthDate() {
		return this.birthDate;
	}
	
	// 캡슐화(쓰기)
	public void setBirthDate(String s) {
		this.birthDate = s;
	}
	 */
	
	
	// 우클릭 - source - generate setter and getter - 필드 모두 선택 - 접근제한자 public 
	
	
	
	
	
}
