xml.instruct!
xml.utu do
  xml.user_id(@user.id)
  xml.sclass_id(@user.sclass.id)
  xml.admin(@user.access_for_level?(User.al_admin))
end