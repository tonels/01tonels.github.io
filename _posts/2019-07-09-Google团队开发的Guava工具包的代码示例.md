## 上一篇   [java代码如何连接Linux虚拟机，还有文件上传下载，等基础命令](https://blog.csdn.net/qq_42105629/article/details/95055700)
## 一、项目源地址 [Github 链 接](https://github.com/google/guava)
## 二、String 操作
### 2.1 Join
示例代码

```
@Test   // 这个包引的是 org.testng.annotations.Test
public class JoinerTest {

    public void shouldJoinList() {
        final List<String> strings = Lists.newArrayList("first", "second", "third", null, "fifth");

        assertEquals("first|second|third|empty|fifth", Joiner.on("|").useForNull("empty").join(strings));
        assertEquals("first|second|third|fifth", Joiner.on("|").skipNulls().join(strings));
    }
    public void shouldJoinMap() {
        final Map<String, String> params = ImmutableMap.of("key1", "value1", "key2", "value2");
        assertEquals("key1=value1&key2=value2", Joiner.on("&").withKeyValueSeparator("=").join(params));
    }
}
```

### 2.2 Splitter
```
@Test
public class SplitterTest {

    public void shouldSplitIntoList() {
        final String input = "first,second,third,fourth,,,seventh";

        ArrayList<String> strings = Lists.newArrayList("first", "second", "third", "fourth", "", "", "seventh");

        ArrayList<String> strings1 = Lists.newArrayList(Splitter.on(",").split(input));
        ArrayList<String> strings2 = Lists.newArrayList(Splitter.on(",").omitEmptyStrings().split(input));
        ArrayList<String> strings3 = Lists.newArrayList(Splitter.on(",").trimResults().split(input));
    }
    public void shouldSplitIntoMap() {
        final String input = "key1=value1&key2=value2";
        ImmutableMap<String, String> of = ImmutableMap.of("key1", "value1", "key2", "value2");
        Map<String, String> split = Splitter.on("&").withKeyValueSeparator("=").split(input);
    }
}
```
### 其他
```
@Test
public class StringsTest {

    private static final String EMPTY = "";
    private static final String NON_EMPTY = "Non-Empty";

    public void shouldHandleNulls() {
        // emptyToNull
        assertNull(Strings.emptyToNull(EMPTY));
        assertEquals(NON_EMPTY, Strings.emptyToNull(NON_EMPTY));

        // nullToEmpty
        assertEquals(EMPTY, Strings.nullToEmpty(null));
        assertEquals(NON_EMPTY, Strings.nullToEmpty(NON_EMPTY));

        // isNullOrEmpty
        assertTrue(Strings.isNullOrEmpty(EMPTY));
        assertTrue(Strings.isNullOrEmpty(null));
        assertFalse(Strings.isNullOrEmpty(NON_EMPTY));
    }

    public void shouldCreateStrings() {
        // padStart
        assertEquals("xxxx" + NON_EMPTY, Strings.padStart(NON_EMPTY, 13, 'x'));
        assertEquals(NON_EMPTY, Strings.padStart(NON_EMPTY, 1, 'x'));

        // padEnd
        assertEquals(NON_EMPTY + "xxxx", Strings.padEnd(NON_EMPTY, 13, 'x'));
        assertEquals(NON_EMPTY, Strings.padEnd(NON_EMPTY, 1, 'x'));

        // repeat
        assertEquals("xyzxyz", Strings.repeat("xyz", 2));
    }
}
```


## 三、集合操作
### 3.1 ImmutableCollections 操作
```
@Test
public class ImmutableCollectionsTest {


    // 自动同步，复制
    public void shouldProveUnmodifiableListIsAView() {
        final List<String> baseList = Lists.newArrayList("A", "B", "C");
        final List<String> unmodifiableList = Collections.unmodifiableList(baseList);

        assertEquals(3, baseList.size());
        assertEquals(3, unmodifiableList.size());

        baseList.add("D");

        assertEquals(4, baseList.size());
        assertEquals(4, unmodifiableList.size());
    }

    public void shouldProveImmutableListIsADifferentList() {
        final List<String> baseList = Lists.newArrayList("A", "B", "C");
        final List<String> unmodifiableList = ImmutableList.copyOf(baseList);

        assertEquals(3, baseList.size());
        assertEquals(3, unmodifiableList.size());

        baseList.add("D");

        assertEquals(4, baseList.size());
        assertEquals(3, unmodifiableList.size());
    }

    public void shouldBuildImmutableList() {
        final List<String> immutableList = ImmutableList.of("A", "B", "C", "D");
//        immutableList.add("E"); // 不可变集合，强行添加会报错
        assertEquals(4, immutableList.size());
    }

    // 这里可实现集合的叠加
    public void shouldBuildImmutableListWithBuilder() {
        final List<String> list1 = Lists.newArrayList("A", "B");
        final List<String> list2 = Lists.newArrayList("C", "D");
        final List<String> list3 = Lists.newArrayList("E", "F");

        final List<String> immutableList = ImmutableList.<String>builder()
                .addAll(list1)
                .addAll(list2)
                .addAll(list3)
                .add("X", "Y", "Z")
                .build();
        assertEquals(9, immutableList.size());
    }

    // 自定义复杂 Map操作
    public void shouldBuildImmutableMultimapWithBuilder() {
        Multimap<String, Integer> immutableMultimap = ImmutableMultimap.<String, Integer>builder()
                .put("A", 1)
                .putAll("B", 1, 2, 3, 4)
                .putAll("C", 10, 15, 20)
                .build();

        assertEquals(1, immutableMultimap.get("A").size());
        assertEquals(4, immutableMultimap.get("B").size());
        assertEquals(3, immutableMultimap.get("C").size());
    }
}
```
### 3.2 collection 操作
```
@Test
public class Collections2Test {

    private Collection<Person> people;

    @BeforeMethod
    public void setup() {
        people = Lists.newArrayList(
                new Person(0, "First", "Person"),
                new Person(1, "Mary", "Jones"),
                new Person(2, "Michael", "Parker")
        );
    }

    public void shouldFilterCollection() {
        final Collection<Person> filtered = Collections2.filter(people,
                new Predicate<Person>() {
                    public boolean apply(@Nullable Person input) {
                        return input != null && input.getFirstName().startsWith("M");
                    }
                });
        filtered.forEach(System.out::println);

        assertEquals(2, filtered.size());
    }

    public void shouldFilterCollection2() {
        final Collection<Person> filtered = Collections2.filter(people,
                new Predicate<Person>() {
                    @Override
                    public boolean apply(@org.checkerframework.checker.nullness.qual.Nullable Person input) {
                        return false;
                    }
                });
        filtered.forEach(System.out::println);

        assertEquals(2, filtered.size());
    }

    public void shouldTransformCollection() {
        // better to use the collection-specific version on Lists, Maps, Sets, etc.
        final Collection<String> transformed = Collections2.transform(people,
                input -> input != null ? input.getFirstName() : "");
        transformed.forEach(System.out::println);
    }

    public void ImmutableSetUnionTest() {
        Person p1 = new Person(1, "zhang", "san");
        Person p2 = new Person(2, "wang", "wu");
        Person p3 = new Person(3, "li", "qi");
        Person p4 = new Person(4, "zhao", "si");

        ImmutableSet<Person> set1 = ImmutableSet.of(p1, p2, p3);
        ImmutableSet<Person> set2= ImmutableSet.of(p2, p4);
        assertEquals(4, Sets.union(set1, set2).size());

        assertEquals(ImmutableSet.of(p2), Sets.intersection(set1, set2)); // 取交集
    }

}

```
### 3.3 Iterables 操作
```
@Test
public class IterablesTest {

    private List<String> strings = ImmutableList.of("something", "another", "thing", "test");

    public void shouldCheckIfAllTrue() {
        final Predicate<String> longerThan5Chars = new Predicate<String>() {
            @Override
            public boolean apply(@Nullable String input) {
                return input != null && input.length() > 5;
            }
        };

        final boolean allLongerThan5Chars = Iterables.all(strings, longerThan5Chars);
        final boolean someLongerThan5Chars = Iterables.any(strings, longerThan5Chars);

        assertFalse(allLongerThan5Chars);
        assertTrue(someLongerThan5Chars);
    }

    public void shouldReturnFirstItemStartingWithT() {

        final String firstItemStartingWithT = Iterables.find(strings, new Predicate<String>() {
            @Override
            public boolean apply(@Nullable String input) {
                return input != null && input.startsWith("t");
            }
        });

        assertEquals("thing", firstItemStartingWithT);
    }

    public void shouldReturnDefaultItem() {

        final String defaultItem = "hello";

        final String result = Iterables.find(strings, new Predicate<String>() {
            @Override
            public boolean apply(@Nullable String input) {
                return input != null && input.startsWith("X");
            }
        }, defaultItem);

        assertEquals(defaultItem, result);
    }
}
```
## 四、IO 操作
```
@Test
public class IoTest {
    public void messAroundWithFile() {
        File file = new File("d:/woop.txt");
        try {
            Files.touch(file);
            Files.write("Hey sailor!\n hello li", file, Charsets.UTF_8);
            List<String> lines = Files.readLines(file, Charsets.UTF_8);
            lines.forEach(System.out::println);
        } catch (IOException e) {
            Throwables.propagate(e);
        }
    }
}
```



