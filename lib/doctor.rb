class Doctor

attr_reader(:name, :specialization)

  def initialize(name, specialization)
    @name = name
    @specialization = specialization
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      specialization = result['specialization']
      doctors << Doctor.new(name, specialization)
    end
    doctors
  end

  def save
    database = PG.connect({:dbname => 'doc_office'})
    DB.exec("INSERT INTO doctors (name, specialization) VALUES ('#{name}', '#{specialization}');")
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialization == another_doctor.specialization
  end

  def self.search(user_input)
    result = DB.exec("SELECT * FROM doctors WHERE name = '#{user_input}' OR specialization = '#{user_input}'")
    search_result = []
    result.each do |result|
      name = result['name']
      specialization = result ['specialization']
      search_result << name + ", " + specialization
    end
    search_result
  end
end
