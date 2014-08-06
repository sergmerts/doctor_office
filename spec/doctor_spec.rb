require 'spec_helper'

describe "Doctor" do
  it "initializes doctors with names, id, specialty_id " do
    test_doctor = Doctor.new({:name => "Dr. Doom", :insurance_id => nil, :specialty_id => nil})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it "lets you read doctors' name" do
    test_doctor = Doctor.new({:id => 1, :name => "Dr. Doom"})
    expect(test_doctor.name).to eq "Dr. Doom"
    expect(test_doctor.id).to eq 1
  end

  it 'starts with no doctors' do
    expect(Doctor.all).to eq []
  end

  it 'lets you save doctors to the database' do
    doctor = Doctor.new({:name => "Dr. Doom", :insurance_id => 1, :specialty_id => 2})
    doctor.save
    expect(Doctor.all).to eq [doctor]
  end

  it 'is the same doctor if it has the same name and the same id' do
    doctor1 = Doctor.new({:id => 1, :name => "Dr. Doom"})
    doctor2 = Doctor.new({:id => 1, :name => "Dr. Doom"})
    expect(doctor1).to eq doctor2
  end

  it 'sets its ID when you save it' do
    doctor1 = Doctor.new({:name => "Dr. Doom",:insurance_id => 2, :specialty_id => 1})
    doctor1.save
    expect(doctor1.id).to be_an_instance_of Fixnum
  end

  it "lets you search by name and get the id" do
    test_doctor = Doctor.new({:name => "Dr. Doom",:insurance_id => 2, :specialty_id => 1})
    test_doctor_2 = Doctor.new({:name => "Dr. Death",:insurance_id => 1, :specialty_id => 1})
    test_doctor.save
    test_doctor_2.save
    expect(Doctor.search_by_name('Dr. Doom')).to eq test_doctor.id
  end

  it "lets you search by specialty and get the special doctors" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery"})
    test_doctor = Doctor.new({:name => "Dr. Doom",:insurance_id => 2, :specialty_id => 1})
    test_doctor_2 = Doctor.new({:name => "Dr. Death",:insurance_id => 1, :specialty_id => 2})
    test_doctor.save
    test_doctor_2.save
    expect(Doctor.search_for_specialist(1)).to eq test_doctor.name
  end
end


