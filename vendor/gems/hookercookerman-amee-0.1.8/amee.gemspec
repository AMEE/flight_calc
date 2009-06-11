# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amee}
  s.version = '0.1.8'
  
  s.homepage = 'http://github.com/hookercookerman/amee/tree/master'
  s.description = %q{Its a gem to interact with the amee api}
  s.summary = %q{Amee}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Hooker"]
  s.date = %q{2009-04-24}

  s.email = ["richard.hooker@dynamic50.com"]
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "LICENSE.txt", "Manifest.txt", "README.rdoc", "Rakefile", "amee.gemspec", "features/config.feature", "features/data/data_category.feature", "features/data/data_item.feature", "features/data/data_item_value.feature", "features/data/drill_down.feature", "features/development.feature", "features/profile/create.profile.feature", "features/profile/create.profile_item.feature", "features/profile/delete.profile.feature", "features/profile/delete.profile_item.feature", "features/profile/get.profile.feature", "features/profile/profile_category.feature", "features/profile/profile_item.feature", "features/profile/profiles.feature", "features/profile/update.profile_item.feature", "features/session/reauthenticate.feature", "features/step_definitions/amee_steps.rb", "features/step_definitions/common_steps.rb", "features/step_definitions/config_steps.rb", "features/step_definitions/data_steps.rb", "features/step_definitions/profile_category_steps.rb", "features/step_definitions/profile_item_steps.rb", "features/step_definitions/profile_steps.rb", "features/support/amee/auth/response.json", "features/support/amee/data.json", "features/support/amee/data/transport/car/generic.json", "features/support/amee/data/transport/car/generic/E57D6E2828EB.json", "features/support/amee/data/transport/car/generic/drill.json", "features/support/amee/data/transport/car/generic/drill?fuel=diesel&size=large.json", "features/support/amee/data/transport/car/generic/drill?fuel=diesel.json", "features/support/amee/data/transport/plane/generic.json", "features/support/amee/data/transport/plane/generic/FFC7A05D54AD.json", "features/support/amee/data/transport/plane/generic/FFC7A05D54AD/kgCO2PerPassengerJourney.json", "features/support/amee/data_category.json", "features/support/amee/data_category_with_data_items.json", "features/support/amee/profiles.json", "features/support/amee/profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157.json", "features/support/amee/profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157?distance=400&representation=true.json", "features/support/amee/profiles/180D73DA5229/home.json", "features/support/amee/profiles/48B97680BCCF/home/energy/quantity/response.json", "features/support/amee/profiles/7C7D68C2A7CD/home.json", "features/support/amee/profiles/E0BCB3704D15.json", "features/support/amee/profiles/E0BCB3704D15/Business.json", "features/support/amee/profiles/F38ECBD56D59/home/energy/quantity/5891C88F29FA.json", "features/support/amee/profiles/profile.json", "features/support/env.rb", "init.rb", "lib/amee.rb", "lib/amee/config.rb", "lib/amee/data_api/data_category.rb", "lib/amee/data_api/data_item.rb", "lib/amee/data_api/data_item_value.rb", "lib/amee/data_api/drill_down.rb", "lib/amee/data_api/item_definition.rb", "lib/amee/data_api/item_value_definition.rb", "lib/amee/data_api/value_definition.rb", "lib/amee/logging.rb", "lib/amee/model.rb", "lib/amee/parser.rb", "lib/amee/profile_api/profile.rb", "lib/amee/profile_api/profile_category.rb", "lib/amee/profile_api/profile_item.rb", "lib/amee/service.rb", "lib/amee/session.rb", "lib/amee/utils/string.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "spec/amee_spec.rb", "spec/service_spec.rb", "spec/session_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake", "tasks/yard.rake"]
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc']
  s.rdoc_options << '--inline-source' << '--charset=UTF-8'

  s.require_paths = ["lib"]
  s.rubyforge_project = %q{amee}
  s.rubygems_version = %q{1.3.2}


  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, ["= 0.4.3"])
      s.add_runtime_dependency(%q<wycats-moneta>, [">= 0"])
      s.add_runtime_dependency(%q<mislav-will_paginate>, [">= 2.2.3"])
    else
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
      s.add_dependency(%q<httparty>, ["= 0.4.3"])
      s.add_dependency(%q<wycats-moneta>, [">= 0"])
      s.add_dependency(%q<mislav-will_paginate>, [">= 2.2.3"])
    end
  else
    s.add_dependency(%q<mislav-will_paginate>, [">= 2.2.3"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<httparty>, ["= 0.4.3"])
    s.add_dependency(%q<wycats-moneta>, [">= 0"])
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end