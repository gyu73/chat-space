
###messagesテーブル

| column | type|
|:-----------|------------:|
| body | text |
| image | text |
| user_id  | integer |
| group_id |  integer |

###usersテーブル

| column | type|
|:-----------|------------:|
| nickname | text |
| e-mail | text |

###groupsテーブル

| column | type|
|:-----------|------------:|
| group_name | text |

### users_groupsテーブル

| column | type|
|:-----------|------------:|
| user_id  | integer |
| group_id |  integer |
| nickname | text |
| e-mail | text |
| group_name | text |


          class Message < ActiveRecord::Base

          belongs_to : user
          belongs_to : group

          end

          class User < ActiveRecord::Base

          has_many : users_groups
          has_many : groups , through: :users_groups
          end

          class Group < ActiveRecord::Base

          has_many : users_groups
          has_many : users , through: :users_groups

          end
