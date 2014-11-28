cli-app
=======

CLI-APP-guide

  Bài viết này sẽ hướng dẫn về CLI app. Thế nào là một CLI app và cách tạo một CLI app bằng ngôn ngữ Ruby 
với module là ```Readline```.

1. CLI app là gì?

 CLI app là viết tắt của ```command-line-interface application```, hiểu một cách đơn giản là một app mà 
 thao tác bằng dòng lệnh trên terminal hoặc cmd. Với lập trình viên thì một CLI app mà chúng ta thường làm
 hằng ngày là git. Sử dụng các câu lệnh ```git status```, ``` git add ```, ``` git commit ``` là đang thao tác
 với git app. Hoặc trong Ruby on Rails thì ví dụ về CLI app là pry, irb hay rails console
 
2. Phân loại CLI app

 CLI app được chia làm 2 loại:
  - Single-line-shell app: Tức là các app mà chỉ có thể thực hiện được một câu lệnh khi gọi app, muốn thúc hiện
  câu lệnh khác phải gọi lại app. Ví dụ cho loại này là git. Mỗi khi cần thực hiện lệnh git thì phải gọi lại git
  - REPL app (read-eval-print-loop app): Là app có thể thực hiện đươc nhiều câu lệnh chỉ với một lần gọi app cho đến
  khi gọi lệnh thoát app. Ví dụ cho loại này là pry, rails console. REPL là đọc dòng lệnh, thực hiện, in ra màn hình
  và lặp lại việc đó.
  
 Về bản chất thì REPL app là Single-line-shell app và thêm vòng loop. Một single-line-shell app dễ dàng thành REPL app với việc thêm một vòng loop như ``` while(true) end```.

3. Công cụ hỗ trợ tạo CLI app

 Đối với single-line-shell app thì có thể sử dụng gem thor. Gem thor khá là dễ dùng nên bạn có thể đọc source code và hướng dẫn sử dụng cho Thor ở link github: https://github.com/erikhuda/thor. 
 
 Đổi với REPL app thì có thể sử dụng một module được tích hợp vào ruby là ``` Readline```. Dưới đây sẽ là phần hướng dẫn sử dụng cho Readline và app đơn giản kèm theo.
 
4. Readline

 Readlin là một module được viết dựa trên GNU Readline của Linux và nay thì được tích hợp vào Ruby.
 Vì đã được tích hợp sẵn trong Ruby nên để sử dụng Readline chỉ cần require 
 ```ruby
   require 'readline'
 ```
 Để đọc dòng lệnh thì đơn dùng method ```readline()``` của module, và để thành một REPL app thì thêm vòng while như dưới đây
 ```ruby
  while line = Readline.readline('>> ', true)
    #code xử lý cho từng lệnh
  end
 ```
 Options ```'>>'``` để hiển thị >> ở dong line để dễ dàng phân biệt đâu là dòng lệnh và đâu là kết quả. Các bạn có thể thay bằng pry(main) chẳng hạn để giống pry trong ROR.
 
 Để hiển thị history command - những lệnh đã được dùng thì chỉ cần dùng hằng số HISTORY của Readline như dưới đây
 ```ruby
  while buf = Readline.readline("> ", true)
    p Readline::HISTORY.to_a
    print("-> ", buf, "\n")
  end
 ```
 Ví dụ code để khi người dùng nhập lệnh history sẽ hiển thị lịch sử các lệnh đã nhập như sau
 ```ruby
  require 'readline'
   
   def history
    Readline::HISTORY.to_a.each do |history|
    puts history
   end
   
   while line = Readline.readline('>> ', true)
    history if line.index "history"
   end
 ```
 
 Muốn auto complete lệnh bước đầu tiên bạn sẽ phải tạo 1 list các lệnh sẽ có trong app của bạn, sau đó dùng các method ``` completion_append_character``` và ``` completion_proc``` để có thể auto complete được lệnh.
 
 ```ruby
  LIST = [
    'newest_feed', 'near_feed', 'post_picture',
    'post_status',
    'help', 'history', 'quit',
  ].sort
 
 comp = proc { |s| LIST.grep( /^#{Regexp.escape(s)}/ ) }

 Readline.completion_append_character = " "
 Readline.completion_proc = comp
 ```
 Vì đã tích hợp sẵn GNU Readline của Linux nên là khi ấn Up-key thì sẽ hiện lại các lệnh gần đây nhất hoặc ấn Ctrl + D thì sẽ thoát app.
 Trên đây là những hướng dẫn cơ bản để có một Command-line-inteface app. Và các chức năng cơ bản một CLI app. Để tìm hiểm thêm về Readling thì các bạn có thể tìm đọc docs cho Readline:
 http://ruby-doc.org/stdlib-2.1.1/libdoc/readline/rdoc/Readline.html. 
 
5. Demo app

 Trên đây là demo app về sử dụng Readline trong Ruby. App có chức năng là để show feed hay là post status, post picture lên Facebook. 
 Để chạy app thì cần có các gem sau 
 ```
  gem install koala --pre
  gem install omniauth
  gem install omniauth-facebook
 ```
Chạy app bằng lệnh ``` ruby cli-app.rb```
Các lệnh trong app ( gõ help để lấy được các lệnh trong app):
```
newest_feed: Lấy feed mới nhất
near_feed: Lấy 5 feed mới nhất
post_status message : Post message lên fb
help: hiển thị các lệnh
history: show lịch sử các lệnh
post_picture link_url_picture message: Post picture kèm message lên fb
```
