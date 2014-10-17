import Prelude hiding (lookup)
import Data.Map (Map, lookup)

data Trie a = { value :: Maybe a,
                children :: Map Char (Trie a) }

find :: String -> Trie a -> Maybe a
find []     t = value t
find (k:ks) t = do
  childTrie <- lookup k (children t)
  find ks childTrie

