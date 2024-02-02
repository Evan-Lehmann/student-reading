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

  @doc """
  Generate a completed_story.
  """
  def completed_story_fixture(attrs \\ %{}) do
    {:ok, completed_story} =
      attrs
      |> Enum.into(%{
        is_completed: true
      })
      |> App.Quiz.create_completed_story()

    completed_story
  end

  @doc """
  Generate a mcq.
  """
  def mcq_fixture(attrs \\ %{}) do
    {:ok, mcq} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> App.Quiz.create_mcq()

    mcq
  end

  @doc """
  Generate a mcq_answer.
  """
  def mcq_answer_fixture(attrs \\ %{}) do
    {:ok, mcq_answer} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> App.Quiz.create_mcq_answer()

    mcq_answer
  end

  @doc """
  Generate a word.
  """
  def word_fixture(attrs \\ %{}) do
    {:ok, word} =
      attrs
      |> Enum.into(%{
        content: "some content",
        hint: "some hint",
        sentence: "some sentence"
      })
      |> App.Quiz.create_word()

    word
  end

  @doc """
  Generate a level.
  """
  def level_fixture(attrs \\ %{}) do
    {:ok, level} =
      attrs
      |> Enum.into(%{

      })
      |> App.Quiz.create_level()

    level
  end
end
