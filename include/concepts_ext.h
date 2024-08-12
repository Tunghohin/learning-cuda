#ifndef _CONCEPT_EXT_H
#define _CONCEPT_EXT_H

#include <memory>
#include <type_traits>
#include <string>
#include <cstdint>

namespace sgimg {

template <typename T>
struct is_basic_string : std::false_type {};

template <typename Elem, typename Traits, typename Alloc>
struct is_basic_string<std::basic_string<Elem, Traits, Alloc>> : std::true_type {};

template <typename T>
constexpr bool is_basic_string_v = is_basic_string<T>::value;

template <class Elem>
concept default_erasable = requires(Elem * p) {
    std::destroy_at(p);
};

template <class Elem, class Traits, class Alloc>
concept allocator_erasable = requires(Alloc m, Elem * p) {
    requires std::same_as<typename Traits::allocator_type, typename std::allocator_traits<Alloc>::template rebind_alloc<Elem>>;
    std::allocator_traits<Alloc>::destroy(m, p);
};

template <class T>
concept allocator_aware = requires (T a) {
    { a.get_allocator() } -> std::same_as<typename T::allocator_type>;
};

template <class E, class T>
concept erasable = (is_basic_string_v<T> && default_erasable<E>)
                || (allocator_aware<T> && allocator_erasable<E, T, typename T::allocator_type>) 
                || (!allocator_aware<T> && default_erasable<E>);

template <typename T>
concept IsContainer = requires(T a, T const b)
{
    requires std::regular<T>;
    requires std::swappable<T>;
    requires erasable<typename T::value_type, T>;
    requires std::same_as<typename T::reference, typename T::value_type &>;
    requires std::same_as<typename T::const_reference, const typename T::value_type &>;
    requires std::forward_iterator<typename T::iterator>;
    requires std::forward_iterator<typename T::const_iterator>;
    requires std::signed_integral<typename T::difference_type>;
    requires std::same_as<typename T::difference_type, typename std::iterator_traits<typename T::iterator>::difference_type>;
    requires std::same_as<typename T::difference_type, typename std::iterator_traits<typename T::const_iterator>::difference_type>;
    { a.begin() } -> std::same_as<typename T::iterator>;
    { a.end() } -> std::same_as<typename T::iterator>;
    { b.begin() } -> std::same_as<typename T::const_iterator>;
    { b.end() } -> std::same_as<typename T::const_iterator>;
    { a.cbegin() } -> std::same_as<typename T::const_iterator>;
    { a.cend() } -> std::same_as<typename T::const_iterator>;
    { a.size() } -> std::same_as<typename T::size_type>;
    { a.max_size() } -> std::same_as<typename T::size_type>;
    { a.empty() } -> std::convertible_to<bool>;
};

template <typename T, typename U = T>
concept Addable = requires(T const& a, U const& b) { a + b; };

template <typename T, typename U = T>
concept Subable = requires(T const& a, U const& b) { a - b; };

template <typename T, typename U = T>
concept Mulable = requires(T const& a, U const& b) { a * b; };

template <typename T, typename U = T>
concept Divable = requires(T const& a, U const& b) { a / b; };

template <typename T>
concept IsIntegral = std::is_integral_v<T>;

}

#endif