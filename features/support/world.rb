module Helper

  include DatesHelper

  def parent_element(element)
    element.find(:xpath, './/..')
  end

end
World(Helper)