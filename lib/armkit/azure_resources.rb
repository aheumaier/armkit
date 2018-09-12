class AzureResources

  @@obj_cache = []

  def self.obj_cache
    if @@obj_cache.empty?
      [Azure::Compute::Mgmt::V2017_12_01::Models, Azure::Network::Mgmt::V2017_09_01::Models ].each do |const|
        @@obj_cache.push(*const.constants.map(&const.method(:const_get)).grep(Class))
      end
    end
    @@obj_cache
  end
end