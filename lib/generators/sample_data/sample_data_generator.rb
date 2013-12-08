class SampleDataGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' 
 

  def populate_wiggles
    Wiggle.destroy_all

    File.open(File.expand_path("lib/generators/sample_data/wiggles.yml"), "r").each_line do |line|
      unless line.empty?
        Wiggle.create(:name => line.chomp, :description => LOREM_IPSUM) 
      end
    end
  end

end
