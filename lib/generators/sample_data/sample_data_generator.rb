class SampleDataGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ultricies, felis eu volutpat imperdiet, purus elit posuere purus, in varius arcu ante commodo nunc. Sed malesuada venenatis lorem eu egestas. Ut consectetur porta nisi vehicula ornare. Curabitur ut enim lorem. Curabitur aliquet dolor tortor, et semper ipsum egestas eget. Sed eu scelerisque est, et luctus neque. Mauris mattis neque ac tellus luctus feugiat.' 
 

  def populate_wiggles
    Wiggle.destroy_all

    File.open(File.expand_path("lib/generators/sample_data/wiggles.yml"), "r").each_line do |line|
      unless line.empty?
        Wiggle.create(:name => line.chomp, :description => LOREM_IPSUM) 
      end
    end
  end

end
