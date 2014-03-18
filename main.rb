require 'pg'
require './lib/doctor'
require './lib/patient'

DB = PG.connect({:dbname => 'doc_office'})

def main_menu
  puts "Patient Portal"
  puts "Press 'p' to search patients or 'a' to add a patient."
  puts "Press 'd' to search doctors or 'c' to add a doctor."
  puts "Press 'x' to exit"
  user_input = gets.chomp
  case user_input
  when 'p'
    search_patient
  when 'a'
    add_patient
  when 'd'
    search_doctor
  when 'c'
    add_doctor
  when 'x'
    exit
  end
end


  def add_doctor
    puts "What is the doctor's name?"
    name = gets.chomp
    puts "What is the doctor's specialization?"
    specialization = gets.chomp

    new_doctor = Doctor.new(name, specialization)
    new_doctor.save

    puts "Doctor Added!"
    main_menu
  end

  def search_doctor
    puts "Search doctors by name or specialty: "
    user_input = gets.chomp
    result = Doctor.search(user_input)
    puts result
  end

main_menu
