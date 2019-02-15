config = lambda do |_|
  namespace 'org/cinnamon' do
    namespace 'desktop/interface' do
      set 'clock-show-date', true
    end

    namespace 'sounds' do
      %w[login logout unplug tile plug switch maximize unmaximize minimize close
         map].each { |name| set "#{name}-enabled", false }
    end

    namespace 'settings-daemon' do
      namespace 'peripherals/touchpad' do
        set 'natural-scroll', false
        set 'scroll-method', "'two-finger-scrolling'"
        set 'horiz-scroll-enabled', true
      end

      set 'plugins/power/button-power', "'interactive'"
    end
  end
end

class CinnamonConfig
  def initialize
    @namespace = ''
  end

  def self.configure(&block)
    CinnamonConfig.new.instance_eval(&block)
  end

  # @param name [String]
  def namespace(name, &block)
    old_namespace = @namespace
    @namespace = [old_namespace, name.gsub(%r{(^/|/$)}, '')].join('/')

    instance_eval(&block)

    @namespace = old_namespace
  end

  # @param name [String]
  def set(name, new_value)
    path = if @namespace
             [@namespace, name.gsub(%r{(^/|/$)}, '')].join('/')
           else
             name
           end

    # format: dconf write /this/is/the/path ('value' | true)
    system("dconf write '#{path}' \"#{new_value.to_s.gsub(/(^"|"$)/, "'")}\"")
  end
end

CinnamonConfig.configure(&config)
