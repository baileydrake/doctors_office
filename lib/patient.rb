class Patient

  attr_reader(:name, :birthday, :doctor_name)

  def initialize(name, birthday, doctor_name)
    @name = name
    @birthday = birthday
    @doctor_name = doctor_name
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      birthday = result['birthday']
      doctor_name = result['doctor_name']
      patients << Patient.new(name, birthdate, doctor_name)
    end
    patients
  end

  def save
    database = PG.connect({:dbname => 'doc_office'})
    DB.exec("INSERT INTO patients (name, birthday, doctor_name) VALUES ('#{name}', '#{birthday}', '#{doctor_name}');")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthday == another_patient.birthday
  end

  def self.search(user_input)
    result = DB.exec("SELECT * FROM patients WHERE name LIKE '%#{user_input}%' OR birthday LIKE '%#{user_input}%' OR doctor_name LIKE '%#{user_input}%'")
    search_result = []
    result.each do |result|
      name = result['name']
      birthday = result['birthday']
      doctor_name = result['doctor_name']
      search_result << name + " : " + birthday + " : " + doctor_name
    end
    search_result
  end

    def self.doctor(user_input)
    results = DB.exec("SELECT * FROM patients WHERE doctor_name = '#{user_input}';")
    patients = []
    results.each do |result|
      name = result['name']
      patients << name
    end
    patients
  end

end
