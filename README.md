
## messages : チャットの内容保存
## users : ユーザー情報の保存
## chat_groups : チャットグループの保存
## users_chat_groups : usersとchat_groupsの中間テーブル




# messagesテーブル

| column  | type |
|:-----------|------------:|
| content  | string |
| image | text |
| user_id  | integer |
| group_id|  integer |

# usersテーブル

| column | type |
|:-----------|------------:|
| nickname | string |
| email | string |

# chat_groupsテーブル

| column | type |
|:-----------|------------:|
| name | string |

# users_chat_groupsテーブル(中間テーブルイメージ)

| column | type |
|:-----------|------------:|
| user_id  | integer |
| group_id |  integer |
| nickname | string |
| e-mail | string |
| name | string |


  class Message < ActiveRecord::Base

    belongs_to : user
    belongs_to : chat_group

  end

  class User < ActiveRecord::Base

    has_many : messages
    has_many : users_chat_groups
    has_many : chat_groups , through: :users_chat_groups
  end

  class ChatGroup < ActiveRecord::Base

    has_many : :messages
    has_many : users_chat_groups
    has_many : users , through: :users_chat_groups

  end
