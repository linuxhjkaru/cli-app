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
  
 Về bản chất thì REPL app là Single-line-shell app và thêm vòng loop. Một single-line-shell app dễ dàng thành REPL app
bằng việc thêm một vòng loop như ``` while(true) end```.

3. Công cụ hỗ trợ tạo CLI app

 Đối với single-line-shell app thì có thể sử dụng gem thor. Source code và hướng dẫn sử dụng cho Thor ở link github: https://github.com/erikhuda/thor.
 Đổi với REPL app thì có thể sử dụng một module được tích hợp vào ruby là ``` readline```

