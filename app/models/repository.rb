class Repository < ActiveRecord::Base
  attr_accessible :comment, :footprint, :itemNo, :manufacturer, :partName, :partRef, :quantity, :supplier_id, :totalprice, :unitprice
  belongs_to :supplier
  validates_presence_of :itemNo
  validates_numericality_of :quantity, :greater_than=>0
# import material
   def self.update(file)
   spreadsheet = open_spreadsheet(file)
   header = spreadsheet.row(4)
   (5..spreadsheet.last_row).each do |i|
     row = Hash[[header, spreadsheet.row(i)].transpose]
    
#    boy = find_by_id(row["itemNo"]) 
#    boy.attributes = row.to_hash.slice(*accessible_attributes)
#    if find_by_id(row["id"])
#    boy=find_by_id(row["id"])
#    boy.name=(boy.name.to_i-row.to_hash['name'].to_i).to_s
#    boy.email=row.to_hash['email']

	    if find_by_itemNo(row["itemNo"])
 	    boy=find_by_itemNo(row["itemNo"])
 	    boy.itemNo=row.to_hash['itemNo'] 
 	    boy.partRef=row.to_hash['partRef'] 
 	    boy.partName=row.to_hash['partName']
 	    boy.footprint=row.to_hash['footprint']
 	    boy.quantity=row.to_hash['quantity']
 	    boy.created_at=Time.now+8
 	    boy.updated_at=Time.now+8
 	    boy.save!
 	    else if !row.to_hash['itemNo'].nil?
 	    boy=new
 	    boy.itemNo=row.to_hash['itemNo'] 
 	    boy.partRef=row.to_hash['partRef'] 
 	    boy.partName=row.to_hash['partName']
 	    boy.footprint=row.to_hash['footprint']
 	    boy.quantity=row.to_hash['quantity']
 	    boy.created_at=Time.now+8
 	    boy.updated_at=Time.now+8
 	    boy.save!
 	    end
 	    end
    end
  end

def self.import(file, number)
 
			  if number.empty? || number.to_i<=0 
				  spreadsheet = open_spreadsheet(file)
				  header = spreadsheet.row(4)
				  new 
				  (5..spreadsheet.last_row).each do |i|
				    row = Hash[[header, spreadsheet.row(i)].transpose]
				#    boy = find_by_id(row["id"]) || new
				#    boy.attributes = row.to_hash.slice(*accessible_attributes)
				    if find_by_itemNo(row["itemNo"])
				    boy=find_by_itemNo(row["itemNo"])
			      num=boy.quantity.to_i/row.to_hash['quantity'].to_i
				    move(num)
				    end
				  end
				else
				  good
				  spreadsheet = open_spreadsheet(file)
				  header = spreadsheet.row(4)
				  (5..spreadsheet.last_row).each do |i|
				    row = Hash[[header, spreadsheet.row(i)].transpose]
				    if find_by_itemNo(row["itemNo"])
				    boy=find_by_itemNo(row["itemNo"])
				    come(row.to_hash['itemNo'].to_i.to_s, boy.quantity.to_i-row.to_hash['quantity'].to_i*number.to_i)
				    end
				  end
				 
				end
	
	
end

def self.good 
	@x=[]
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
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end
