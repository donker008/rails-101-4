module GroupsHelper

  def render_group_description(group)
    return simple_format(group.description)
  end
end
