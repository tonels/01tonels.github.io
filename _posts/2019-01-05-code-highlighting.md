---
layout: post
title: "A quick demo of  theme's code highlighting features"
description: "A quick demo of  theme's code highlighting features"
categories: [demo]
tags: [demo, jekyll]
redirect_from:
  - /2019/01/05/
---

> 代码高亮显示Demo.

* Kramdown table of contents，自动生成层级目录Demo
{:toc .toc}

# Code Spans

This is a test for inline codeblocks like `C:/Ruby23-x64` or `SELECT  "offices".* FROM "offices" `

Here is a literal `` ` `` backtick.
And here is a Ruby code fragment `x = Class.new`{:.language-ruby}

# Fenced Code Blocks

~~~~~~~~~~~~
~~~~~~~
code with tildes
~~~~~~~~
~~~~~~~~~~~~~~~~~~

# Simple codeblock with long lines

    function myFunction() {
        alert("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
    }

# Language of Code Blocks

~~~ ruby
def what?
  42
end
~~~

# Highlighted

## External Gist

<script src="https://gist.github.com/yizeng/9b871ad619e6dcdcc0545cac3101f361.js"></script>

## Simple Highlight

{% highlight ruby %}
def foo
  puts 'foo'
end
{% endhighlight %}

## Highlight with long lines

{% highlight c# %}
public class Hello {
    public static void Main() {
        Console.WriteLine("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
    }
}
{% endhighlight %}

## Highlight with line numbers and long lines

{% highlight javascript linenos=table %}
function myFunction() {
    alert("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
}
{% endhighlight %}

[^1]: This is a footnote.

[kramdown]: https://kramdown.gettalong.org/
[]: https://github.com/tonels/tonels.github.io