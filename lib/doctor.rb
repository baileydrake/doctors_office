class Doctor

attr_reader(:name, :specialization, :insurance)

  def initialize(name, specialization, insurance)
    @name = name
    @specialization = specialization
    @insurance = insurance
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      specialization = result['specialization']
      insurance = result['insurance']
      doctors << Doctor.new(name, specialization)
    end
    doctors
  end

  def save
    DB.exec("INSERT INTO doctors (name, specialization, insurance) VALUES ('#{name}', '#{specialization}', #{insurance});")
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialization == another_doctor.specialization
  end

  def self.search(user_input)
    result = DB.exec("SELECT * FROM doctors WHERE name LIKE '%#{user_input}%' OR specialization LIKE '%#{user_input}%' OR insurance LIKE '%#{user_input}%'")
    search_result = []
    result.each do |result|
      name = result['name']
      specialization = result['specialization']
      insurance = result['insurance']
      search_result << Doctor.new(name, specialization, insurance) #name + ", " + specialization + ", " + insurance
    end
    search_result
  end

  def self.list
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      doctors << name
    end
    doctors
  end
end
