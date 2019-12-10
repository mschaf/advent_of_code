Dir.glob('lib/**/*.rb').each do |file|
  require file.gsub(/\Alib\//, '')
end