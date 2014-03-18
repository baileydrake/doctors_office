require 'spec_helper'

describe Doctor do
  it 'is initalized with a name and specialization' do
    doctor = Doctor.new('Dr. James', "pediatrics")
    doctor.should be_an_instance_of Doctor
  end
  it 'should return the doctor name and specialization' do
    doctor = Doctor.new('Dr. James', 'pediatrics')
    doctor.name.should eq 'Dr. James'
    doctor.specialization.should eq 'pediatrics'
  end
  it 'starts off with no doctors' do
    Doctor.all.should eq []
  end
  it 'lets you save dr to the database' do
    doctor = Doctor.new('Dr. James', 'pediatrics')
    doctor.save
    Doctor.all.should eq [doctor]
  end
  it 'is the same doctor if it has the same name and specialization' do
    doctor = Doctor.new('Dr. James', 'pediatrics')
    doctor2 = Doctor.new('Dr. James', 'pediatrics')
    doctor.should eq doctor2
  end
  it 'returns the name and specialty of searched' do
    doctor = Doctor.new('Dr. Lennon', 'cardiology')
    doctor.save
    doctor.search('Dr. Lennon').should eq ['Dr. Lennon', 'cardiology']
  end
end
