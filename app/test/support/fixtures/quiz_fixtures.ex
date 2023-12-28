defmodule App.QuizFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Quiz` context.
  """

  @doc """
  Generate a story.
  """
  def story_fixture(attrs \\ %{}) do
    {:ok, story} =
      attrs
      |> Enum.into(%{
        context: "some context"
      })
      |> App.Quiz.create_story()

    story
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> App.Quiz.create_question()

    question
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        content: "some content",
        is_correct: true
      })
      |> App.Quiz.create_answer()

    answer
  end
end
