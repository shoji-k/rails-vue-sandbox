password = 'Password1!'

User.seed_once(:id,
               {
                 id: 1,
                 name: 'system user',
                 email: 'system@sample.com',
                 role: :system,
                 password: password,
                 password_confirmation: password
               },
               {
                 id: 2,
                 name: 'admin user',
                 email: 'admin@sample.com',
                 role: :admin,
                 password: password,
                 password_confirmation: password
               },
               {
                 id: 3,
                 name: 'normal user',
                 email: 'normal@sample.com',
                 role: :normal,
                 password: password,
                 password_confirmation: password
               })
