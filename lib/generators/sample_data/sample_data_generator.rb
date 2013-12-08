require 'yaml'

class SampleDataGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' 
 

  def populate_wiggles
    puts "Destroying previous data..."
    Wiggle.destroy_all    

    puts "Loading new sample data..."
    sample = YAML.load_file(File.expand_path("lib/generators/sample_data/wiggles.yml"))

    print "Creating Wiggles..."
    sample["wiggles"].each do |wiggle| 
      print "."
      Wiggle.create(:name => wiggle["name"].chomp, :description => LOREM_IPSUM)
    end

    puts "\nSample data generation complete."
  end

end
