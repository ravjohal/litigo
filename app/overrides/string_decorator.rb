# Security vulnerability fix where constantize can be injected and changed through urls; http://blog.littleimpact.de/index.php/2008/08/13/constantize-with-care/
String.class_eval do

  def constantize_with_care(list_of_klasses=[])
    list_of_klasses.each do |klass|
      return self.constantize if self == klass.to_s
    end
    raise "I'm not allowed to constantize #{self}!"
  end

end