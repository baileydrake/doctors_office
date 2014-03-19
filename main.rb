require 'pg'
require './lib/doctor'
require './lib/patient'

DB = PG.connect({:dbname => 'doc_office'})

def main_menu
  puts "Press 'p' to search patients or 'a' to add a patient."
  puts "Press 'd' to search doctors or 'c' to add a doctor."
  puts "Press 'x' to exit"
  user_input = gets.chomp.upcase
  case user_input
  when 'P'
    search_patient
  when 'A'
    add_patient
  when 'D'
    search_doctor
  when 'C'
    add_doctor
  when 'X'
    exit
  end
end

  def add_patient
    puts "What is the patient's name?"
    name_input = gets.chomp.upcase
    puts "What is the patient's birthdate?"
    birthdate_input = gets.chomp.upcase
    puts "What is their doctor's name?"
    doctor_input = gets.chomp.upcase

    new_patient = Patient.new(name_input, birthdate_input, doctor_input)
    new_patient.save

    puts "Patient Added!"
    main_menu
  end

  def search_patient
    puts "Search patients by name or doctor: "
    name_input = gets.chomp.upcase
    result = Patient.search(name_input)
    puts "Name          Birthday         DR      "
    puts "---------------------------------------"
    puts result
    puts "\n\n"
    main_menu
  end

  def add_doctor
    puts "What is the doctor's name?"
    name = gets.chomp.upcase
    puts "What is the doctor's specialization?"
    specialization = gets.chomp.upcase
    puts "What insurance does the DR accept"
    insurance = gets.chomp.upcase

    new_doctor = Doctor.new(name, specialization, insurance)
    new_doctor.save

    puts "Doctor Added!"
    main_menu
  end

  def search_doctor
    puts "Search doctors by name or specialty or insurance: "
    user_input = gets.chomp.upcase
    result = Doctor.search(user_input)
    puts result
    puts "Press 'p' to see their patients or 'm' for main menu"
    user_input = gets.chomp.upcase
    case user_input
    when 'P'
      doctor_patients
    when 'M'
      main_menu
    end
  end

  def doctor_patients
    puts "Enter Doctor's name: "
    user_input = gets.chomp.upcase
    result = Patient.doctor(user_input)
    puts result
    main_menu
  end

  def doctor_list
    Doctor.all.each_with_index do |doctor, index|
      puts "#{index + 1}: #{doctor.name}"
    end
  end



main_menu
