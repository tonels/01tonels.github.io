## 问题出现：在练习QueryDsl和JPA的整合时，需要定义一个类，实现Specification<T>接口
```
public class QueryParams<T> implements Specification<T> {

    @Override
    public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        return null;
    }

}
```
## 其实自己在刚学java基础的时候，应该有看过这个，但那时刚开始，就没注意，包括以后，在工作时，也几乎不需要注意这些东西（web接口），只是简单知道，实现一个接口，就要实现接口里的所有方法，其实是错的……
## 这里的Specification接口，源码如下
```
public interface Specification<T> extends Serializable {

	long serialVersionUID = 1L;

	static <T> Specification<T> not(Specification<T> spec) {
		return Specifications.negated(spec);
	}

	static <T> Specification<T> where(Specification<T> spec) {
		return Specifications.where(spec);
	}

	default Specification<T> and(Specification<T> other) {
		return Specifications.composed(this, other, AND);
	}

	default Specification<T> or(Specification<T> other) {
		return Specifications.composed(this, other, OR);
	}
	
	@Nullable
	Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder);
}
```
## 两个静态方法，两个 Default修饰的 and & or 方法，是有方法体的，还有一个抽象接口 toPredicate 没有方法体，当New 出这个对象或者 实现这个接口的时候，是必须要实现这个接口的,，静态方法是不允许重写的，两个有方法体的方法可以选择性的重写 或实现（都是一个意思，至少作用一样）