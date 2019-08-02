org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'customerController': Injection of resource dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'customerServiceImpl': Injection of resource dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'customerRepo': Invocation of init method failed; nested exception is java.lang.IllegalArgumentException: Not a managed type: class tonel.model.CustomersEntity

## 一、解决，添加 @EntityScan("tonel.model") 注解，即可解决
多种方式，可以多个包扫描
```

@SpringBootApplication
@EntityScan(basePackages ={ "tonel.model","tonels.qbe.model"})
//@SpringBootApplication(scanBasePackages = {"org.ashu.java.*"})
//@EnableJpaRepositories(basePackages ={ "org.ashu.java.*"})
//@EntityScan(basePackages ={ "org.ashu.java.*"})
public class QbeApp {
    public static void main(String[] args) {
        ConfigurableApplicationContext run = SpringApplication.run(QbeApp.class);
    }
}

```
## 二、思考，源码
```
/*
 * Copyright 2012-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.boot.autoconfigure.domain;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.context.annotation.Import;
import org.springframework.core.annotation.AliasFor;


@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import(EntityScanPackages.Registrar.class)
public @interface EntityScan {
	/**
	 * Alias for the {@link #basePackages()} attribute. Allows for more concise annotation
	 * declarations e.g.: {@code @EntityScan("org.my.pkg")} instead of
	 * {@code @EntityScan(basePackages="org.my.pkg")}.
	 * @return the base packages to scan
	 */
	@AliasFor("basePackages")
	String[] value() default {};

	/**
	 * Base packages to scan for entities. {@link #value()} is an alias for (and mutually
	 * exclusive with) this attribute.
	 * <p>
	 * Use {@link #basePackageClasses()} for a type-safe alternative to String-based
	 * package names.
	 * @return the base packages to scan
	 */
	@AliasFor("value")
	String[] basePackages() default {};

	/**
	 * Type-safe alternative to {@link #basePackages()} for specifying the packages to
	 * scan for entities. The package of each class specified will be scanned.
	 * <p>
	 * Consider creating a special no-op marker class or interface in each package that
	 * serves no purpose other than being referenced by this attribute.
	 * @return classes from the base packages to scan
	 */
	Class<?>[] basePackageClasses() default {};

}

```
## 三、出现场景，我从一个别的Module中引入的common Module的Entity，出现的错误，从当前Module不会出现这个问题。