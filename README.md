
### messagesテーブル

| column  | type |
|:-----------|------------:|
| content  | string |
| image | text |
| user_id  | integer |
| group_id|  integer |

### usersテーブル

| column | type |
|:-----------|------------:|
| nickname | string |
| email | string |

### groupsテーブル

| column | type |
|:-----------|------------:|
| name | string |

### users_groupsテーブル

| column | type |
|:-----------|------------:|
| user_id  | integer |
| group_id |  integer |
| nickname | string |
| e-mail | string |
| name | string |


  class Message < ActiveRecord::Base

    belongs_to : user
    belongs_to : group

  end

  class User < ActiveRecord::Base

    has_many : messages
    has_many : users_groups
    has_many : groups , through: :users_groups
  end

  class Group < ActiveRecord::Base

    has_many : :messages
    has_many : users_groups
    has_many : users , through: :users_groups

  end
