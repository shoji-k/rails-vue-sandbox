password = 'Password1!'

User.seed_once(:id,
               {
                 id: 1,
                 name: 'user one',
                 email: 'sample@sample.com',
                 password: password,
                 password_confirmation: password
               })
