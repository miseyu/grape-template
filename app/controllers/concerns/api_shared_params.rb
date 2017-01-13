module APISharedParams
  extend Grape::API::Helpers

  params :pagination do
    optional :page, type: Integer
    optional :per_page, type: Integer
  end

  params :period do
    optional :started_at, type: Time
    optional :ended_at, type: Time
  end
end
