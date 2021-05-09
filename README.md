# AttributedText

AttributedText is a view for displaying some HTML-tagged text using **SwiftUI Text View**.

A simple example of usage.

**Code example:**

```swift
AttributedText("A unit of <i>length</i> equal to <b>one hundred-millionth of a centimetre</b>, 10<sup>−10</sup> metre, used mainly to express <u>wavelengths and interatomic distances</u>.")
```

**Result:**

![Example](./Images/Example.png)



## Features

You can clone the repo and run the **AttributedTextExample** project to explore the `AttributedText` features.

These are the main points to pay attention to.

1. Basic modifiers can still be applied, such as changing the font and color of the text.

   **Code example:**

   ```swift
   AttributedText("This is <b>bold</b> and <i>italic</i> text.")
       .foregroundColor(.blue)
       .font(.title)
   ```

   **Result:**

   ![1 feature](./Images/1%20feature.png)

2. Handles unopened/unclosed tags.

   **Code example:**

   ```swift
   AttributedText("This is italic</i> and <b>bold text.")
   ```

   **Result:**

   ![2 feature](./Images/2%20feature.png)

3. Supports overlapping tags.

   **Code example:**

   ```swift
   AttributedText("This is <b>bold only, <i>bold and italic</b> and italic only</i> text.")
   ```

   **Result:**

   ![3 feature](./Images/3%20feature.png)

4. Deletes tags that have no modifiers.

   **Code example:**

   ```swift
   AttributedText("<unknown>This is <b>bold</b> and <i>italic</i> text.</unknown>")
   ```

   **Result:**

   ![4 feature](./Images/4%20feature.png)
   
5. Does **not** handle HTML characters such as `&amp;`.

   **Code example:**

   ```swift
   AttributedText("This is <b>bold</b> &amp; <i>italic</i> text.")
   ```

   **Result:**

   ![5 feature](./Images/5%20feature.png)
   
6. **Only single-word tags are supported**. Tags with more than one word or containing any characters besides **letters** or **numbers** are ignored and not removed.

   **Code example:**

   ```swift
   AttributedText("This is <tag attribute1=\"value1\"> <b>bold</b> and <i>italic</i> text</tag>.")
   ```

   **Result:**

   ![6 feature](./Images/6%20feature.png)



## Installation and usage

#### Via Swift Package Manager

1. In Xcode 11 or greater select `File ▸ Swift Packages ▸ Add Package Dependency`.
2. Paste the link to this repo https://github.com/Iaenhaall/AttributedText.git and click **Next**.
3. Define the package options for this package or select the default. Click **Next**.
4. Xcode downloads the code from GitHub and adds the package to the your project target. Click **Finish**.

#### Manually

1. Add **[AttributedText.swift](https://github.com/Iaenhaall/AttributedText/blob/master/Sources/AttributedText/AttributedText.swift)** and **[HTML2TextParser.swift](https://github.com/Iaenhaall/AttributedText/blob/master/Sources/AttributedText/HTML2TextParser.swift)** files to your project.

2. Modify or complement the **availableTags** dictionary in the **HTML2TextParser** class.

   You need to add the required tags and provide associated closures. Each closure must be a modifier that is applied to the SwiftUI Text View when a specific tag is encountered. For example:

   ```swift
   private let availableTags: Dictionary<String, (Text) -> (Text)> = [
       "b": { $0.bold() },
       "i": { $0.italic() }
   ]
   ```

   In this case only **\<b\>** and **\<i\>** tags will be processed. All other tags will be ignored or deleted.

