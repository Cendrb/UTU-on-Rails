xml.instruct!
xml.utu do
  xml.status do
    xml.code(0)
    xml.message('Login successful')
  end
  xml.user do
    xml.user_id(@user.id)
    xml.sclass_id(@user.sclass.id)
    xml.admin(@user.access_for_level?(User.al_admin))
    xml.full_name(@user.class_member.full_name)
    xml.class_member_id(@user.class_member.id)
    xml.email(@user.email)
  end
end