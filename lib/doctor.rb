require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'doctors_office'})

class Doctor

  attr_accessor(:id, :name, :insurance_id, :specialty_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @insurance_id = attributes[:insurance_id]
    @specialty_id = attributes[:specialty_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      insurance_id = result['insurance_id'].to_i
      specialty_id = result['specialty_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({:name => name, :insurance_id => insurance_id, :specialty_id => specialty_id, :id => id })
    end
    doctors
  end

  def save

    results = DB.exec("INSERT INTO doctors (name, insurance_id, specialty_id) VALUES ('#{@name}', #{@insurance_id}, #{@specialty_id}) RETURNING id;")

    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.id == another_doctor.id
  end

  def self.search_by_name(name)
    Doctor.all.detect { |doctor| doctor.name == name }.id
  end


end
