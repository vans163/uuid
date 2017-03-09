-module(uuid).
-export([v4/0]).

%Thanks zxq9, https://github.com/zxq9/zuuid

v4() ->
    <<A1:48, _:4, B1:12, _:2, C1:62>> = crypto:strong_rand_bytes(16),
    Variant = 2,  % Indicates RFC 4122
    Version = 4,  % UUID version number
    Uuid4 = <<A1:48, Version:4, B1:12, Variant:2, C1:62>>,

    <<A:4/binary, B:2/binary, C:2/binary, D:2/binary, E:6/binary>> = Uuid4,
    Parts = [{A, 8}, {B, 4}, {C, 4}, {D, 4}, {E, 12}],
    list_to_binary(string:to_lower(string:join(bins_to_strhexs(Parts), "-"))).

bins_to_strhexs(List) ->
    [binary_to_strhex(X) || X <- List].
binary_to_strhex({Bin, Size}) ->
    string:right(integer_to_list(binary:decode_unsigned(Bin, big), 16), Size, $0).
