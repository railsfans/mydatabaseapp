class Boy < ActiveRecord::Base
  attr_accessible :email, :name, :age
  validates_numericality_of :age, :greater_than=>18
#  validates_presence_of :email
#  def self.to_csv
#    CSV.generate do |csv|
#      csv << column_names
#      all.each do |boy|
#        csv << boy.attributes.values_at(*column_names)
#      end
#    end
#  end
   def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
  
  

#def self.import(file)
#  CSV.foreach(file.path, headers: true) do |row|
#    Boy.create! row.to_hash
#  end
#end



#def self.import(file)
#  CSV.foreach(file.path, headers: true) do |row|
#    boy = find_by_id(row["id"]) || new
#    boy.attributes = row.to_hash.slice(*accessible_attributes)
#    boy.save!
#  end
#end

 

def self.import(file, number)
  if number.empty? || number.to_i<=0
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(3)
	  new 
	  (4..spreadsheet.last_row).each do |i|
	  	move(i)
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	#    boy = find_by_id(row["id"]) || new
	#    boy.attributes = row.to_hash.slice(*accessible_attributes)
	    if find_by_id(row["id"])
	    boy=find_by_id(row["id"])
	    boy.name=(boy.name.to_i-row.to_hash['name'].to_i).to_s
	    boy.email=row.to_hash['email']
	#    boy.created_at=Time.now+8
	#    boy.updated_at=Time.now+8
	    boy.save!
	    end
	  end
	else
	  good
	  @a=[9,number.to_i] 
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(3)
	  (4..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	   
	    come(row.to_hash['email'],row.to_hash['age'].to_i-number.to_i)
	  end
	 
	end
	
end

def self.good 
	@x=[]
	@y=[]
end

def self.come(x,y)
@x << x
@x << y
end

def self.calu
h=Hash[*@x]
h.select{ |k, v| v<0 }.empty? ? "no short material" : h.select{ |k,v| v<0 }
end

def self.new 
@a=[]
end

def self.move(i)
@a << i
end

def self.cal
@a
end

 

def self.open_spreadsheet(file)
  if file
	  case File.extname(file.original_filename)
	  when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
	  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
	  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end 
	else
	  raise "no file"
	end
end



end
