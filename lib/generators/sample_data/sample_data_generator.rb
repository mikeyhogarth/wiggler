require 'yaml'

class SampleDataGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' 

  #
  # Create sample wiggles from yml file 
  #
  def populate_wiggles
    return if Wiggle.exists?
    print "Creating Wiggles..."
    sample = YAML.load_file(File.expand_path("lib/generators/sample_data/wiggles.yml"))

    sample["wiggles"].each do |wiggle| 
      print "."
      Wiggle.create(:name => wiggle["name"].chomp, :description => LOREM_IPSUM)
    end
  end


  #
  # Create a sample test user
  #
  def create_user_if_none_exist
    return if User.exists?
    puts "Creating Users..."

    User.create :email => "test@test.com", :password => "welcome1", :password_confirmation => "welcome1"
  end


end
