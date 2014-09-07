# Require supporting files
# - config:  settings for test components
# - support: custom matchers, macros
%w( config support ).each do |dir|
  require_all "spec/#{dir}"
end

RSpec.configure do |config|
  # Show detailed output if only one file is run
  config.default_formatter = 'doc' if config.files_to_run.one?

  # Provide spec-type specific helpers (such as for controller specs) based on
  # spec subdirectory (e.g. spec/controllers)
  config.infer_spec_type_from_file_location!

  # Run specs in random order to surface order dependencies
  config.order = 'random'
end
