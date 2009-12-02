# encoding: utf-8
#
# This demonstrates the Prawn ability to print some standard labels
#
require "#{File.dirname(__FILE__)}/../example_helper.rb"

require "prawn/measurement_extensions"

#  Label dscriptions from:
#  http://www.worldlabel.com/Pages/labels.htm
#  Label dimensions from pdf template page under each label
#  
AVERYS ={
"avery 5160" => {
    :name => "avery 5160",
    :length => 2.59350.in ,
    :height => 1.00000.in,
    :top => 0.50000.in  ,
    :bottom => 0.50000.in,
    :left => 0.21975.in ,
    :right => 0.21975.in,
    :column_gutter => 0.14000.in  ,
    :row_gutter => 0.00000.in,
    :intended_use => "standard address label",
    :columns => 3,
    :rows => 10,
    :labels => 30},
"avery 5167" => {
    :name => "avery 5167",
    :length => 1.75000.in ,
    :height => 0.50000.in,
    :top => 0.50000.in  ,
    :bottom => 0.50000.in,
    :left => 0.33000.in ,
    :right => 0.33000.in,
    :column_gutter => 0.28125.in  ,
    :row_gutter => 0.00000.in,
    :intended_use => "return address label",
    :columns => 4,
    :rows => 20,
    :labels => 80},
"avery 5166" => {
    :name => "avery 5166",
    :length => 1.75000.in ,
    :height => 0.50000.in,
    :top => 0.50000.in  ,
    :bottom => 0.50000.in,
    :left => 0.33000.in ,
    :right => 0.33000.in,
    :column_gutter => 0.28125.in  ,
    :row_gutter => 0.00000.in,
    :intended_use => "return addess label",
    :columns => 4,
    :rows => 20,
    :labels => 80},
"avery 6571" => {
    :name => "avery 6571",
    :length => 3.00000.in ,
    :height => 0.62500.in,
    :top => 0.50000.in  ,
    :bottom => 0.50000.in,
    :left => 0.84150.in ,
    :right => 0.84150.in,
    :column_gutter => 0.81700.in  ,
    :row_gutter => 0.00000.in,
    :intended_use => "id badges, office, file labels",
    :columns => 2,
    :rows => 16,
    :labels => 32},
"avery 6874" => {
    :name => "avery 6874",
    :length => 3.75000.in ,
    :height => 3.00000.in,
    :top => 0.62500.in  ,
    :bottom => 0.62500.in,
    :left => 0.37500.in ,
    :right => 0.37500.in,
    :column_gutter => 0.25000.in  ,
    :row_gutter => 0.37500.in,
    :intended_use => "shipping, mailings, product labels",
    :columns => 2,
    :rows => 3,
    :labels => 6},
}
# inputs:
#   label - a hash defining a label's parameters
#   content - text to put on on the label
#   grid - print the outline of the label (typically false)
#
#   Label definition: 
#    :name => "avery 6874",
#    :length => 3.75000.in ,
#    :height => 3.00000.in,
#    :top => 0.62500.in  ,
#    :bottom => 0.62500.in,
#    :left => 0.37500.in ,
#    :right => 0.37500.in,
#    :column_gutter => 0.25000.in  ,
#    :row_gutter => 0.37500.in,
#    :intended_use => "shipping, mailings, product labels",
#    :columns => 2,
#    :rows => 3,
#    :labels => 6
#
def generateLabels(label,content,grid=false)
  Prawn::Document.generate 'labels.pdf', 
  :left_margin => label[:left],
  :right_margin => label[:left]  do |p|
    
    p.define_grid(:columns => label[:columns], :rows => label[:rows], :column_gutter => label[:column_gutter])
    p.grid.rows.times do |i|
      p.grid.columns.times do |j|
        b = p.grid(i,j)
        
        p.bounding_box b.top_left, :width => b.width, :height => b.height do
          p.text content, :align => :center
          
          #	Box it.
          if grid
            #    p.grid.show_all  #shows grid in grey.
            # this manually draws it.
            p.stroke do
              p.rectangle(p.bounds.top_left, b.width, b.height)
            end
          end          
        end
      end
    end
  end
end


generateLabels(AVERYS["avery 5166"], "hello world\nHello World", true)
