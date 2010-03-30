module ActiveEnum
  module MixIn
    def enum_attr attr, enums, options={}
      attr = attr.to_s
      self.class_eval <<-EOF
        ENUMS_#{attr.upcase} = enums
        options.merge! :in => enums.map{|e| e[1]}
        validates_inclusion_of attr, options
        def #{attr}_name
          ENUMS_#{attr.upcase}.find{|op| op[1] == #{attr}}[0] unless #{attr}.nil?
        end
      EOF
    end
  end
end

Object.send :include, ActiveEnum::MixIn
