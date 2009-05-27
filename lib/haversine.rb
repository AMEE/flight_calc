class Haversine
  KMS_PER_MILE = 1.609
  EARTH_RADIUS_IN_MILES = 3963.19
  EARTH_RADIUS_IN_KMS = EARTH_RADIUS_IN_MILES * KMS_PER_MILE
  
  def self.distance_between(from, to)
    EARTH_RADIUS_IN_KMS * 
      Math.acos( Math.sin(deg2rad(from.latitude)) * Math.sin(deg2rad(to.latitude)) + 
      Math.cos(deg2rad(from.latitude)) * Math.cos(deg2rad(to.latitude)) * 
      Math.cos(deg2rad(to.longitude) - deg2rad(from.longitude)))  
  end

  def self.deg2rad(degrees)
    degrees.to_f / 180.0 * Math::PI
  end
end