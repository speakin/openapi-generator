{-
   OpenAPI Petstore
   This is a sample server Petstore server. For this sample, you can use the api key `special-key` to test the authorization filters.

   OpenAPI spec version: 1.0.0

   NOTE: This file is auto generated by the openapi-generator.
   https://github.com/openapitools/openapi-generator.git
   Do not edit this file manually.
-}


module Data.Pet exposing (Pet, Status(..), petDecoder, petEncoder)

import Data.Category exposing (Category, categoryDecoder, categoryEncoder)
import Data.Tag exposing (Tag, tagDecoder, tagEncoder)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Json.Encode as Encode
import Maybe exposing (map, withDefault)


{-| A pet for sale in the pet store
-}
type alias Pet =
    { id : Maybe Int
    , category : Maybe Category
    , name : String
    , photoUrls : List String
    , tags : Maybe (List Tag)
    , status : Maybe Status
    }


type Status
    = Available
    | Pending
    | Sold



petDecoder : Decoder Pet
petDecoder =
    decode Pet
        |> optional "id" (Decode.nullable Decode.int) Nothing
        |> optional "category" (Decode.nullable categoryDecoder) Nothing
        |> required "name" Decode.string
        |> required "photoUrls" (Decode.list Decode.string)
        |> optional "tags" (Decode.nullable (Decode.list tagDecoder)) Nothing
        |> optional "status" (Decode.nullable statusDecoder) Nothing



petEncoder : Pet -> Encode.Value
petEncoder model =
    Encode.object
        [ ( "id", withDefault Encode.null (map Encode.int model.id) )
        , ( "category", withDefault Encode.null (map categoryEncoder model.category) )
        , ( "name", Encode.string model.name )
        , ( "photoUrls", (Encode.list << List.map Encode.string) model.photoUrls )
        , ( "tags", withDefault Encode.null (map (Encode.list << List.map tagEncoder) model.tags) )
        , ( "status", withDefault Encode.null (map statusEncoder model.status) )
        ]


statusDecoder : Decoder Status
statusDecoder =
    Decode.string
        |> Decode.andThen (\str ->
            case str of
                "available" ->
                    Decode.succeed Available

                "pending" ->
                    Decode.succeed Pending

                "sold" ->
                    Decode.succeed Sold

                other ->
                    Decode.fail <| "Unknown type: " ++ other
        )


statusEncoder : Status -> Encode.Value
statusEncoder model =
    case model of
        Available ->
            Encode.string "available"

        Pending ->
            Encode.string "pending"

        Sold ->
            Encode.string "sold"



