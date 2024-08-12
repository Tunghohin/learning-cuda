// template <typename T>
//     requires sgimg::IsContainer<T>
// auto display(T const& container) -> void {
//     for (auto const& elem : container) {
//         std::cout << elem << std::endl;
//     }
// }

// enum struct transfer_modes : uint8_t {
//     BULK = 0,
//     ISOCHRONOUS = 1,
// };

// typedef struct _transfer_mode
// {
//     bool is_get;
//     transfer_modes mode;
// } transfer_mode;

// enum struct pkg_request : uint8_t {
//     NEXT = 0,
//     LOST = 1,
// };

// typedef struct _datapacket
// {
//     pkg_request request_type;
//     bool has_next;
//     uint8_t idx;
//     uint8_t checksum;
//     char data[60];
// } datapkg;

// auto get_pkg() -> datapkg {
//     static uint8_t left = 5;
//     static uint8_t count = 0;
//     left -= 1;
//     datapkg pkg {
//         pkg_request::NEXT,
//         left != 0,
//         0,
//     };
//     std::for_each(pkg.data, pkg.data + 60, [](char& c) {
//         c = count + '0';
//         count+=1;
//     });
//     return pkg;
// }
 
// int main()
// {
    // std::vector<datapkg> pkg_buffer;
    // while (true) {
    //     auto pkg = get_pkg();
    //     pkg_buffer.push_back(pkg);
    //     if (!pkg.has_next) break;
    // }
    // std::vector<std::byte> bytestream = 
    // std::accumulate(pkg_buffer.begin(), pkg_buffer.end(), std::vector<std::byte>{},
    //     [] (std::vector<std::byte>&& bs, datapkg const& pkg) {
    //         return std::accumulate(pkg.data, pkg.data + 60, std::move(bs),
    //             [](std::vector<std::byte>&&bs, char const& c) {
    //                 bs.push_back(std::byte(c));
    //                 return bs;
    //             }
    //         );
    //     }
    // );

    // std::ranges::for_each(bytestream, [](auto const& c) {
    //     fmt::print("{}", static_cast<int>(c));
    // });
    // fmt::println("\n{}", bytestream.size());
// }