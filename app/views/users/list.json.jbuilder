json.users @users do |user|
  json.id user.id
  json.label user.label
  json.committee user.committee?
  json.set! 'DT_RowId', user.div
  json.set! 'DT_RowClass', user.committee?.to_s
end
